Return-Path: <bpf+bounces-488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC34702005
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 23:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05711C209B3
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAFDC124;
	Sun, 14 May 2023 21:49:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA601FCE
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 21:49:47 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF14210CE
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 14:49:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so21933155a12.1
        for <bpf@vger.kernel.org>; Sun, 14 May 2023 14:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684100983; x=1686692983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0MAWgvpOgzI/SGBDb1jXI5+BgxJTKLGsz2Sbj+g3OD0=;
        b=KioFM2a0PFTvpnBvzAEzuRTAs3Zix6LIiWfk65M4HiKGpt+ihnRBGZ5lE7NjgUaN4h
         7P/Z4pjD5mwXHTdtgVVbnRJMNDY0KyS7n2ykeQOYWh7AynBmuxOelfhs6gSOy9FqPKwJ
         /E/8nb23VzJqwS5zTMpeJu7MzN5Qfr/HuaJnqaHfaJ10woo+JbG8+ez55MLgEcEPAMbk
         q36Mp7lfP6O1cVq18oOOMpULAV5j62DZLn5E+Wi9zBla7HJAE3trnjm19HdlPu2Otxxh
         LqF6QVyc1wXjtRvVBo0EPJyMyiWOw/zePGd1wl0Kk1OdCSmw0Sn68o10AptKwAS4rRUl
         BbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684100983; x=1686692983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MAWgvpOgzI/SGBDb1jXI5+BgxJTKLGsz2Sbj+g3OD0=;
        b=RsMfShCqblfPi88JA9d2iv7KY4cW29MqorMA6QicIif1llzxqE+YLp2M1SqAy6jx12
         wJjnJjj2YOpzSxemBRL0DibKQTytwESDTxh3sl66FOoJlUV1kcjIOwwEEh+0/hex6gZn
         o2QOIbAQWD+9KQQf2WRSintaViEQSk/4ZIKvm4LMuJ44BDr5VeNcM0vRHon8Lr4+/r0l
         jQxMkv8cKK15fpkHDTwM8RAYWvETMeQC4ClhSbrD8ka+CswtGSOWbbgHO915ivZxrjw2
         2gx5EVtKvHxycAyH8OsgRn+qP2BQX2DzlcbegpYSTJeLgFPCM8VyMu8zrnG2eybOF933
         f6Rw==
X-Gm-Message-State: AC+VfDxvN38umU2EGCkHTfqIafl/+i5fF4aLnoU4yKpCrL1c3PONo14o
	n0eHwePDFJ3vxEgvngrTonc=
X-Google-Smtp-Source: ACHHUZ6F4rXMfKR/Wq9YQtzYO9plgSgV2FnTn13BDDIWv6j+EwOysGZWhAAmDdCSIdB/9FLBnxXoUw==
X-Received: by 2002:a05:6402:295:b0:50b:c6c9:2146 with SMTP id l21-20020a056402029500b0050bc6c92146mr22032126edv.24.1684100982830;
        Sun, 14 May 2023 14:49:42 -0700 (PDT)
Received: from krava ([83.240.60.237])
        by smtp.gmail.com with ESMTPSA id i8-20020a056402054800b0050bd59fd0efsm6303003edx.49.2023.05.14.14.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 14:49:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 14 May 2023 23:49:40 +0200
To: Yonghong Song <yhs@meta.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
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
Message-ID: <ZGFXdAs2dzQiPHq8@krava>
References: <20230510130241.1696561-1-alan.maguire@oracle.com>
 <CALOAHbDeK4SkP7pXdBWJ6Omwq2NyxJrYn6wZTX=z1-VkDtWwMQ@mail.gmail.com>
 <6b15f6ff-8b66-3a78-2df6-5def5cf77203@oracle.com>
 <CAADnVQKDO8_Hnotf40iHLD-GRmJZpz_ygpkYZGRvey0ENJOc0g@mail.gmail.com>
 <ZF61j8WJls25BYTl@krava>
 <278ac187-58ea-7faf-be2d-224886404ea2@meta.com>
 <49e4fee2-8be0-325f-3372-c79d96b686e9@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49e4fee2-8be0-325f-3372-c79d96b686e9@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, May 14, 2023 at 10:37:08AM -0700, Yonghong Song wrote:
> 
> 
> On 5/12/23 7:59 PM, Yonghong Song wrote:
> > 
> > 
> > On 5/12/23 2:54 PM, Jiri Olsa wrote:
> > > On Fri, May 12, 2023 at 11:59:34AM -0700, Alexei Starovoitov wrote:
> > > > On Fri, May 12, 2023 at 9:04 AM Alan Maguire
> > > > <alan.maguire@oracle.com> wrote:
> > > > > 
> > > > > On 12/05/2023 03:51, Yafang Shao wrote:
> > > > > > On Wed, May 10, 2023 at 9:03 PM Alan Maguire
> > > > > > <alan.maguire@oracle.com> wrote:
> > > > > > > 
> > > > > > > v1.25 of pahole supports filtering out functions
> > > > > > > with multiple inconsistent
> > > > > > > function prototypes or optimized-out parameters from
> > > > > > > the BTF representation.
> > > > > > > These present problems because there is no
> > > > > > > additional info in BTF saying which
> > > > > > > inconsistent prototype matches which function
> > > > > > > instance to help guide attachment,
> > > > > > > and functions with optimized-out parameters can lead
> > > > > > > to incorrect assumptions
> > > > > > > about register contents.
> > > > > > > 
> > > > > > > So for now, filter out such functions while adding
> > > > > > > BTF representations for
> > > > > > > functions that have "."-suffixes (foo.isra.0) but
> > > > > > > not optimized-out parameters.
> > > > > > > This patch assumes that below linked changes land in
> > > > > > > pahole for v1.25.
> > > > > > > 
> > > > > > > Issues with pahole filtering being too aggressive in
> > > > > > > removing functions
> > > > > > > appear to be resolved now, but CI and further testing will confirm.
> > > > > > > 
> > > > > > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > > > > > ---
> > > > > > >   scripts/pahole-flags.sh | 3 +++
> > > > > > >   1 file changed, 3 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> > > > > > > index 1f1f1d397c39..728d55190d97 100755
> > > > > > > --- a/scripts/pahole-flags.sh
> > > > > > > +++ b/scripts/pahole-flags.sh
> > > > > > > @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
> > > > > > >          # see PAHOLE_HAS_LANG_EXCLUDE
> > > > > > >          extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> > > > > > >   fi
> > > > > > > +if [ "${pahole_ver}" -ge "125" ]; then
> > > > > > > +       extra_paholeopt="${extra_paholeopt}
> > > > > > > --skip_encoding_btf_inconsistent_proto
> > > > > > > --btf_gen_optimized"
> > > > > > > +fi
> > > > > > > 
> > > > > > >   echo ${extra_paholeopt}
> > > > > > > -- 
> > > > > > > 2.31.1
> > > > > > > 
> > > > > > 
> > > > > > That change looks like a workaround to me.
> > > > > > There may be multiple functions that have the same proto, e.g.:
> > > > > > 
> > > > > >    $ grep -r "bpf_iter_detach_map(struct bpf_iter_aux_info \*aux)"
> > > > > > kernel/bpf/ net/core/
> > > > > >    kernel/bpf/map_iter.c:static void bpf_iter_detach_map(struct
> > > > > > bpf_iter_aux_info *aux)
> > > > > >    net/core/bpf_sk_storage.c:static void bpf_iter_detach_map(struct
> > > > > > bpf_iter_aux_info *aux)
> > > > > > 
> > > > > >    $ bpftool btf dump file /sys/kernel/btf/vmlinux   |  grep -B 2
> > > > > > bpf_iter_detach_map
> > > > > >    [34691] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
> > > > > >    'aux' type_id=2638
> > > > > >    [34692] FUNC 'bpf_iter_detach_map' type_id=34691 linkage=static
> > > > > > 
> > > > > > We don't know which one it is in the BTF.
> > > > > > However, I'm not against this change, as it can avoid some issues.
> > > > > > 
> > > > > 
> > > > > In the above case, the BTF representation is consistent though.
> > > > > That is, if I attach fentry progs to either of these functions
> > > > > based on that BTF representation, nothing will crash.
> > > > > 
> > > > > That's ultimately what those changes are about; ensuring
> > > > > consistency in BTF representation, so when a function is in
> > > > > BTF we can know the signature of the function can be safely
> > > > > used by fentry for example.
> > > > > 
> > > > > The question of being able to identify functions (as opposed
> > > > > to having a consistent representation) is the next step.
> > > > > Finding a way to link between kallsyms and BTF would allow us to
> > > > > have multiple inconsistent functions in BTF, since we could map
> > > > > from BTF -> kallsyms safely. So two functions called "foo"
> > > > > with different function signatures would be okay, because
> > > > > we'd know which was which in kallsyms and could attach
> > > > > safely. Something like a BTF tag for the function that could
> > > > > clarify that mapping - but just for cases where it would
> > > > > otherwise be ambiguous - is probably the way forward
> > > > > longer term.
> > > > > 
> > > > > Jiri's talking about this topic at LSF/MM/BPF this week I believe.
> > > > 
> > > > Jiri presented a few ideas during LSFMMBPF.
> > > > 
> > > > I feel the best approach is to add a set of addr-s to BTF
> > > > via a special decl_tag.
> > > > We can also consider extending KIND_FUNC.
> > > > The advantage that every BTF func will have one or more addrs
> > > > associated with it and bpf prog loading logic wouldn't need to do
> > > > fragile name comparison between btf and kallsyms.
> > > > pahole can take addrs from dwarf and optionally double check
> > > > with kallsyms.
> > > 
> > > Yonghong summed it up in another email discussion, pasting it in here:
> > > 
> > >    So overall we have three options as kallsyms representation now:
> > >      (a) "addr module:foo:dir_a/dir_b/core.c"
> > >      (b) "addr module:foo"
> > >      (c) "addr module:foo:btf_id"
> > > 
> > >    option (a):
> > >      'dir_a/dir_b/core.c' needs to be encoded in BTF.
> > >      user space either check file path or func signature
> > >      to find attach_btf_id and pass to the kernel.
> > >      kernel can find file path in BTF and then lookup
> > >      kallsyms to find addr.
> > > 
> > >    option (b):
> > >      "addr" needs to be encoded in BTF.
> > >      user space checks func signature to find
> > >      attach_btf_id and pass to the kernel.
> > >      kernel can find addr in BTF and use it.
> > > 
> > >    option (c):
> > >      if user can decide which function to attach, e.g.,
> > >      through func signature, then no BTF encoding
> > >      is necessary. attach_btf_id is passed to the
> > >      kernel and search kallsyms to find the matching
> > >      btf_id and 'addr' will be available then.
> > > 
> > >    For option (b) and (c), user space needs to check
> > >    func signature to find which btf_id to use. If
> > >    same-name static functions having the identical
> > >    signatures, then user space would have a hard time
> > >    to differentiate. I think it should be very
> > >    rare same-name static functions in the kernel will have
> > >    identical signatures. But if we want 100% correctness,
> > >    we may need file path in which case option (a)
> > >    is preferable.
> > 
> > As Alexei mentioned in previous email, for such a extreme case,
> > if user is willing to go through extra step to check dwarf
> > to find and match file path, then (b) and (c) should work
> > perfectly as well.
> 
> Okay, it looks like this is more complex if the function signature is
> the same. In such cases, current BTF dedup will merge these
> functions as a single BTF func. In such cases, we could have:
> 
>    decl_tag_1   ----> dedup'ed static_func
>                          ^
>                          |
>    decl_tag_2   ---------
> 
> For such cases, just passing btf_id of static func to kernel
> won't work since the kernel won't be able to know which
> decl_tag to be associated with.
> 
> (I did a simple test with vmlinux, it looks we have
>  issues with decl_tag_1/decl_tag_2 -> dedup'ed static_func
>  as well since only one of decl_tag survives.
>  But this is a different issue.
> )
> 
> So if we intend to add decl tag (addr or file_path), we
> should not dedup static functions or generally any functions.

I did not think functions would be dedup-ed, they are ;-) with the
declaration tags in place we could perhaps switch it off, right?

or perhaps I can't think of all the cases we need functions dedup for,
so maybe the dedup code could check also the associated decl tag when
comparing functions

jirka

