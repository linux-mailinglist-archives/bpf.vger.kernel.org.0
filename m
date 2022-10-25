Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B686F60D308
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJYSLU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJYSLT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:11:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91E315708
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:11:18 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g129so10622293pgc.7
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZRwIzyW0nV1lobwwIYbOw8yQGu/+QFtPhfGRaUZ1CI=;
        b=BiTTN/nnJXvMRdymNDPw4mC7yZUxkjkLedb0w7fFILbwUKJtVOJk5pfdYxJ9TNS0ep
         loIO9jgvcVtwb/l1bjETtZuXEdP6cxa5hj1DEihdBeB2jWNQor3b0aDK3YK3oPOzePMe
         PM9to/0THjZpsaRa+TZjoaQ93s5pI5J3A4HhypjdiTQTA/cQpOvlm3ZqT19pULVqVYrV
         rEWe8NY4mkOdVfD1bI7zQc8hRAJAdPPgGVwX2Q8rzndMC23aK453HFSfxfA0CqpO9+21
         9BzGmMVzQhtvM8o7qqKpwjj2cDk0trWB3flbeIkYSbkc3EaD7vn+LPGKVqqpKpcqBvCb
         J8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZRwIzyW0nV1lobwwIYbOw8yQGu/+QFtPhfGRaUZ1CI=;
        b=yg6wZDQqgCxhc/bxbY+Kmwo+8IqnYTULQbEHkBhW7T1EVjgX7NTxnmrjWLjUwTRkvx
         yCYotMLNQDfjr3cPQrX87/2BKv2yyZ/63VUW5e12QEU9keHwlOe0v9WBvBaBzhLmxUTb
         GAN7PZ+zn/wsTW3b7xpPWxXalAejVpjsHzOH3v53mdm9GbjeCywv/X2YIVd1RoNANzHa
         z4moSxHlgV+YpD6xXeFmMFPJ8YQbgokfmQws47hvAansHoo4GEJrFOsUzxRcvAOWlf6E
         tXYcO1WLhap05wmS+NeHK71Gpwt/XXHrgUKq28ysTedqnij8TKLcVPLJ5Ut0IJNbpxx0
         zc/A==
X-Gm-Message-State: ACrzQf0XKd7EnEJUvLKT9x0y6Blv/bHF9LJYWdGQEWWhU1JzyklGWGrl
        /ns7hKwZHi+pegiTjAtCPVjXeTCR2n++9Q==
X-Google-Smtp-Source: AMsMyM5wGhAj7YqdWI3TfXB7DVk6aoBxSOHwS0DcGG7kzefMH/24gDKDsNCoD1UrNO8JnqtTdAizDA==
X-Received: by 2002:a05:6a00:224c:b0:56c:40ff:7709 with SMTP id i12-20020a056a00224c00b0056c40ff7709mr1362565pfu.59.1666721478195;
        Tue, 25 Oct 2022 11:11:18 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id h18-20020a056a00001200b0056b8e55f956sm1666280pfk.76.2022.10.25.11.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 11:11:17 -0700 (PDT)
Date:   Tue, 25 Oct 2022 23:41:16 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 10/25] bpf: Introduce local kptrs
Message-ID: <20221025181116.tiqxzo6qevtpiibr@apollo>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-11-memxor@gmail.com>
 <582912fa-3d32-7c5a-cf24-fc79899a2e31@meta.com>
 <20221020004837.qclzg6pgrqamcn7e@apollo>
 <d147dca1-4b8b-338e-103c-9ecdb476f06d@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d147dca1-4b8b-338e-103c-9ecdb476f06d@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 25, 2022 at 09:57:58PM IST, Dave Marchevsky wrote:
> On 10/19/22 8:48 PM, Kumar Kartikeya Dwivedi wrote:
> > On Wed, Oct 19, 2022 at 10:45:22PM IST, Dave Marchevsky wrote:
> >> On 10/13/22 2:22 AM, Kumar Kartikeya Dwivedi wrote:
> >>> Introduce the idea of local kptrs, i.e. PTR_TO_BTF_ID that point to a
> >>> type in program BTF. This is indicated by the presence of MEM_TYPE_LOCAL
> >>> type tag in reg->type to avoid having to check btf_is_kernel when trying
> >>> to match argument types in helpers.
> >>>
> >>> For now, these local kptrs will always be referenced in verifier
> >>> context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
> >>> to such objects, as long fields that are special are not touched
> >>> (support for which will be added in subsequent patches).
> >>>
> >>> No PROBE_MEM handling is hence done since they can never be in an
> >>> undefined state, and their lifetime will always be valid.
> >>>
> >>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >>> ---
>
> [...]
>
> >>
> >>
> >> more re: passing entire reg state to btf_struct access:
> >>
> >> In the next patch in the series ("bpf: Recognize bpf_{spin_lock,list_head,list_node} in local kptrs")
> >> you do btf_find_struct_meta(btf, reg->btf_id). I see why you couldn't use 't'
> >> that's passed in here / elsewhere since you need the btf_id for meta lookup.
> >> Perhaps 'btf_type *t' param can be changed to btf_id, eliminating the need
> >> to pass 'reg'.
> >>
> >> Alternatively, since we're already passing reg->btf and result of
> >> btf_type_by_id(reg->btf, reg->btf_id), seems like btf_struct_access
> >> maybe is tied closely enough to reg state that passing reg state
> >> directly and getting rid of extraneous args is cleaner.
> >>
> >
> > So Alexei actually suggested dropping both btf and type arguments and simply
> > pass in the register and get it from there.
> >
> > But one call site threw a wrench in the plan:
> >
> > check_ptr_to_map_access -> btf_struct_access
> >
> > Here, it passes it's own btf and type to simulate access to a map. Maybe I
> > should be creating a dummy register on stack and make it work like that for this
> > particular case? Otherwise all other callers pass in what they have from reg.
>
> Ah, sorry for missing that. Personally I'm not a fan of dummy register on the
> stack. Then if btf_struct_access starts using some reg state that wasn't
> populated in the dummy reg it will be confusing.

Well, it can be initialized the same way it's done for normal regs. memset to 0
and then mark_reg_known_zero, memset zeroes state untouched by
mark_reg_known_zero (reg->parent, reg->live, etc.). which won't matter here.

In general, your point is valid as well, but I think for this particular case we
can get away with it, moreso because this is the only case needing such
adjustment.

Or maybe it can be split into two, with the inner call taking btf and btf_id,
while the outer one passes them in. Then btf_struct_access uses reg to pass them
in, while __btf_struct_access takes them directly.
