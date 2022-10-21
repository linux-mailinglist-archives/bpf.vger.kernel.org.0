Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF3B607E59
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJUShR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 14:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJUShQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 14:37:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B591EEA0A;
        Fri, 21 Oct 2022 11:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D8ECB82CF5;
        Fri, 21 Oct 2022 18:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB48C433C1;
        Fri, 21 Oct 2022 18:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666377431;
        bh=LUPV3WFGe0VFeT0xn0tDwdGYmTwNgllfk2nwY2G2Cvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KDRt3YykB+rsUHZvJw2KedzwDm/vn/MB9IKsfKXWxJ69az5yFyg4BWQ6jfXmiaOup
         pXjwKKoktv4sha/53zdfD0j8NZ/QFxz4eWZTRJn/D9OlOoksMvqkcymTeUT+Ci1j6w
         20m5aAfI5N1U/nFxs3Ogrs3wzapOgGGOLZnMHTAZRBFDEeKhWNHmWt7iSg1p0gLBYZ
         7NaFXcxoj1LgN8AkRPQRRSlRelPm4Rikil46MaO2O/08LGx2nG2x5uTLiMQBnkcea9
         oFdWBs8V+X71t2F8G7A58OrfOIPoF1pTplgALpFpoMzOF/DrpFZQusAKJUg+AwfRPt
         IN9xL3PaBir0Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2780C40468; Fri, 21 Oct 2022 15:37:09 -0300 (-03)
Date:   Fri, 21 Oct 2022 15:37:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        dwarves@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] dwarves: zero-initialize struct cu in cu__new()
 to prevent incorrect BTF types
Message-ID: <Y1Lm1al9YEGbjd7i@kernel.org>
References: <1666364523-9648-1-git-send-email-alan.maguire@oracle.com>
 <Y1LJlPBQauNS/xkX@krava>
 <CAEf4BzbtRqkcx8CHBqdXXWmWLeX-zsrEYMy_CgL7i48PTYjCNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbtRqkcx8CHBqdXXWmWLeX-zsrEYMy_CgL7i48PTYjCNg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Oct 21, 2022 at 09:35:50AM -0700, Andrii Nakryiko escreveu:
> On Fri, Oct 21, 2022 at 9:32 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > On Fri, Oct 21, 2022 at 04:02:03PM +0100, Alan Maguire wrote:
> > > BTF deduplication was throwing some strange results, where core kernel
> > > data types were failing to deduplicate due to the return values
> > > of function type members being void (0) instead of the actual type
> > > (unsigned int).  An example of this can be seen below, where
> > > "struct dst_ops" was failing to deduplicate between kernel and
> > > module:
> > >
> > > struct dst_ops {
> > >         short unsigned int family;
> > >         unsigned int gc_thresh;
> > >         int (*gc)(struct dst_ops *);
> > >         struct dst_entry * (*check)(struct dst_entry *, __u32);
> > >         unsigned int (*default_advmss)(const struct dst_entry *);
> > >         unsigned int (*mtu)(const struct dst_entry *);
> > > ...
> > >
> > > struct dst_ops___2 {
> > >         short unsigned int family;
> > >         unsigned int gc_thresh;
> > >         int (*gc)(struct dst_ops___2 *);
> > >         struct dst_entry___2 * (*check)(struct dst_entry___2 *, __u32);
> > >         void (*default_advmss)(const struct dst_entry___2 *);
> > >         void (*mtu)(const struct dst_entry___2 *);
> > > ...
> > >
> > > This was seen with
> > >
> > > bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
> > >
> > > ...which rewrites the return value as 0 (void) when it is marked
> > > as matching DW_TAG_unspecified_type:
> > >
> > > static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
> > > {
> > >        if (tag_type == 0)
> > >                return 0;
> > >
> > >        if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
> > >                // No provision for encoding this, turn it into void.
> > >                return 0;
> > >        }
> > >
> > >        return type_id_off + tag_type;
> > > }
> > >
> > > However the odd thing was that on further examination, the unspecified type
> > > was not being set, so why was this logic being tripped?  Futher debugging
> > > showed that the encoder->cu->unspecified_type.tag value was garbage, and
> > > the type id happened to collide with "unsigned int"; as a result we
> > > were replacing unsigned ints with void return values, and since this
> > > was being done to function type members in structs, it triggered a
> > > type mismatch which failed deduplication between kernel and module.
> > >
> > > The fix is simply to calloc() the cu in cu__new() instead.
> > >
> > > Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >
> > awesome, this fixes the missing dedup I was seeing
> > with current pahole:
> >
> >         $ bpftool btf dump file ./vmlinux.test | grep "STRUCT 'task_struct'" | wc -l
> >         69
> >
> > with this patch:
> >
> >         $ bpftool btf dump file ./vmlinux.test | grep "STRUCT 'task_struct'" | wc -l
> >         1
> >
> 
> Nice and a great catch! I generally try to stick to calloc() in libbpf
> exactly so I don't have to worry about stuff like this.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied, my bad, I just changed it to zalloc():

⬢[acme@toolbox pahole]$ grep -A3 'zalloc(size_t' dutil.c
void *zalloc(size_t size)
{
        return calloc(1, size);
}
⬢[acme@toolbox pahole]$

That is used in many places, but unfortunately not on this specific case
:-\

- Arnaldo

⬢[acme@toolbox pahole]$ grep 'zalloc(' *.c
btf_encoder.c:	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
btf_loader.c:	struct tag *tag = zalloc(size);
btf_loader.c:		struct class_member *member = zalloc(sizeof(*member));
btf_loader.c:	struct tag *tag = zalloc(sizeof(*tag));
ctf_loader.c:	struct tag *tag = zalloc(size);
ctf_loader.c:		struct class_member *member = zalloc(sizeof(*member));
ctf_loader.c:		struct class_member *member = zalloc(sizeof(*member));
ctf_loader.c:	struct tag *tag = zalloc(sizeof(*tag));
dutil.c:void *zalloc(size_t size)
dwarf_loader.c:	struct dwarf_cu *dwarf_cu = cu__zalloc(cu, sizeof(*dwarf_cu));
dwarf_loader.c:	struct dwarf_tag *dtag = cu__zalloc(dcu->cu, (sizeof(*dtag) + (spec ? sizeof(dwarf_off_ref) : 0)));
dwarf_loader.c:	struct tag *tag = cu__zalloc(dcu->cu, size);
dwarf_loader.c:		struct type *new_typedef = cu__zalloc(cu, sizeof(*new_typedef));
dwarf_loader.c:		recoded = cu__zalloc(cu, sizeof(*recoded));
dwarf_loader.c:		struct base_type *new_bt = cu__zalloc(cu, sizeof(*new_bt));
dwarf_loader.c:		struct type *new_enum = cu__zalloc(cu, sizeof(*new_enum));
dwarf_loader.c:	annot = zalloc(sizeof(*annot));
dwarf_loader.c:			dcu = zalloc(sizeof(*dcu));
dwarves.c:static void *obstack_zalloc(struct obstack *obstack, size_t size)
dwarves.c:void *cu__zalloc(struct cu *cu, size_t size)
dwarves.c:		return obstack_zalloc(&cu->obstack, size);
dwarves.c:	return zalloc(size);
dwarves.c:	struct cu *cu = zalloc(sizeof(*cu) + build_id_len);
elf_symtab.c:	struct elf_symtab *symtab = zalloc(sizeof(*symtab));
libctf.c:	struct ctf *ctf = zalloc(sizeof(*ctf));
pahole.c:	struct prototype *prototype = zalloc(sizeof(*prototype) + strlen(expression) + 1);
⬢[acme@toolbox pahole]$
