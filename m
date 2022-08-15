Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2679559291F
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 07:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiHOFib (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 01:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHOFia (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 01:38:30 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C96A1582B
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:38:29 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h78so38493iof.13
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=feJeMnlwUFFmNHE35lT4q5QbAfwsoAlUVOZeRTf3NdY=;
        b=aYikpmIenYXiQK0NFT4mItBzX0pJlxSnub0wQlKw9xGszK+x4Nhg235hwOESarxdAr
         s7Gn/C6DfsG+cK0nHb/2QSA8o9qUizemnf9ZcsA71w6D2A9zqiPaq8iDG8nxt6QvA12I
         CCRwX1IyzIB8tXi3kkUkHS+EtNdp05HgDkqC0x26NEmA+HNWpvZjg/HXhionpKiH41gD
         o0FAEGIORRVT3dWyxVxfs/J00MdR57kwr4nPJ6J66f2DBl+0xSX20jna8Idy16Ag7r7Y
         DEiAf+vXbRPkX032jAihDDIQYWqGYa0UqDax1Uylka0l4F98ZMDxLTtBY/xBDSfoUFqC
         Hu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=feJeMnlwUFFmNHE35lT4q5QbAfwsoAlUVOZeRTf3NdY=;
        b=ZEAtjT1cKNZZbcAT/pHN6ldjFJJ9ewbv1mBFbu1tB+2Z5Q5R6xpeT7d8cgL4Jz7WxT
         WW+stJWrs+6jp02bacqKD8xdt/tZD5olbomHb3qq71ISAleC2Pvm8MwiBQPX3FLPBT2W
         nB2JVpwn3iZB0dcMqfEqK6SpQ3Dk4I2mcIO0U15L+zizwu+feLy2AgXROuNNG1QdbhVU
         uyrIHv3GgzGmu4yEPFp/Ai3CH3E0PyuefqVC2gChSrfc3GJZsYNWtqpQdAfmvWz73NxE
         G7UhiwW/Sl36oZpNsajE00+AAW+2HbgoyPMrld+S9IuyWTw03Jm4AzNUIi9WZIPMgt8S
         SENA==
X-Gm-Message-State: ACgBeo0AUXbfqy1CLPZ1C07bPK3v3DcykRWJwsxi16k7pTYvN76FW/uY
        kceE+bOfn64AzP+HM42nU5bzQ0D7phRAtgrApUK1T1wzHd0=
X-Google-Smtp-Source: AA6agR5fCCEkOUrBU+/X43TSKsuj9zHht1GxU2CXMuu8HM3TkYvzZNCbc9JV9Vk3OZPsFJvzug3juywZp1BWs++1F70=
X-Received: by 2002:a05:6638:33a9:b0:345:4756:21e3 with SMTP id
 h41-20020a05663833a900b00345475621e3mr2124670jav.93.1660541908578; Sun, 14
 Aug 2022 22:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-6-davemarchevsky@fb.com> <61209d3a-bc15-e4f2-9079-7bdcfdd13cd0@fb.com>
 <CAP01T75nt69=jgGPGXYXHSGc5EDHejgLQpyY8TMeUy2U4Prxvg@mail.gmail.com> <18a8e565-95d0-80e1-b596-95babf279912@fb.com>
In-Reply-To: <18a8e565-95d0-80e1-b596-95babf279912@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 15 Aug 2022 07:37:52 +0200
Message-ID: <CAP01T74cwoBsOsn3mUBr24TXZMYKONwjp_veWEzBwLxbZiQq9Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 05/11] bpf: Add bpf_spin_lock member to rbtree
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Aug 2022 at 07:34, Yonghong Song <yhs@fb.com> wrote:
>
> On 8/10/22 2:46 PM, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 2 Aug 2022 at 00:23, Alexei Starovoitov <ast@fb.com> wrote:
> [...]
> >
> > Just to continue brainstorming: Comments on this?
> >
> > Instead of a rbtree map, you have a struct bpf_rbtree global variable
> > which works like a rbtree. To associate a lock with multiple
> > bpf_rbtree, you do clang style thread safety annotation in the bpf
> > program:
> >
> > #define __guarded_by(lock) __attribute__((btf_type_tag("guarded_by:" #lock))
> >
> > struct bpf_spin_lock shared_lock;
> > struct bpf_rbtree rbtree1 __guarded_by(shared_lock);
> > struct bpf_rbtree rbtree2 __guarded_by(shared_lock);
>
> For the above __guarded_by macro, we should use
> btf_decl_tag instead of btf_type_tag
>
> #define __guarded_by(lock) __attribute__((btf_decl_tag("guarded_by:" #lock))
>
> Currently, in llvm implementation, btf_type_tag only applies
> to pointee type's. btf_decl_tag can apply to global variable,
> function argument, function return value and struct/union members.
> So btf_decl_tag shoul work for the above global variable case or
> below struct rbtree_set member case.
>

Yep, I actually wrote a prototype list implementation (it's very close
so I can probably post it very soon as an RFC, at this point) which is
using declaration tags like this. For now only one bpf_spin_lock is
there in a map value or globally, so I didn't add guarded_by, but if
you look in [0] it can be used to tag e.g. value_type of a specific
bpf_list_head, which node in that value type can be linked, etc.

  [0]: https://github.com/kkdwivedi/linux/commits/bpf-list
